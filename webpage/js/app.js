document.addEventListener('DOMContentLoaded', () => {
  const STORAGE_KEY        = 'hw_prep_completed_v1';
  const COLLAPSED_KEY      = 'hw_prep_collapsed_categories_v1';
  const THEME_KEY          = 'hw_prep_theme_v1';
  const SECTION_KEY        = 'hw_prep_active_section_v1';

  // ─── Partition questions by section ──────────────────────────────────────────
  const allQuestions = window.QUESTIONS_DATA || [];
  const constraintQs = allQuestions.filter(q => !q.category.includes('Fork-Join'));
  const forkjoinQs   = allQuestions.filter(q =>  q.category.includes('Fork-Join'));

  // ─── Persisted state ─────────────────────────────────────────────────────────
  let completedSet = new Set();
  try { const s = localStorage.getItem(STORAGE_KEY); if (s) completedSet = new Set(JSON.parse(s)); } catch(e) {}

  let collapsedSet = new Set();
  try { const s = localStorage.getItem(COLLAPSED_KEY); if (s) collapsedSet = new Set(JSON.parse(s)); } catch(e) {}

  // ─── Theme ───────────────────────────────────────────────────────────────────
  const savedTheme = localStorage.getItem(THEME_KEY) || 'dark';
  applyTheme(savedTheme);

  function applyTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem(THEME_KEY, theme);
    const iconDark  = document.getElementById('iconDark');
    const iconLight = document.getElementById('iconLight');
    if (iconDark && iconLight) {
      iconDark.style.display  = theme === 'dark' ? 'block' : 'none';
      iconLight.style.display = theme === 'light' ? 'block' : 'none';
    }
  }

  document.getElementById('themeToggle').addEventListener('click', () => {
    const current = document.documentElement.getAttribute('data-theme') || 'dark';
    applyTheme(current === 'dark' ? 'light' : 'dark');
  });

  // ─── Section (Constraints / Fork-Join) ───────────────────────────────────────
  let activeSection = localStorage.getItem(SECTION_KEY) || 'constraints';

  const sectionConstraintsBtn = document.getElementById('sectionConstraints');
  const sectionForkJoinBtn    = document.getElementById('sectionForkJoin');

  function setSection(section) {
    activeSection = section;
    localStorage.setItem(SECTION_KEY, section);

    sectionConstraintsBtn.classList.toggle('active', section === 'constraints');
    sectionForkJoinBtn.classList.toggle('active', section === 'forkjoin');

    // Update hero text
    const heroTitle    = document.getElementById('heroTitle');
    const heroSubtitle = document.getElementById('heroSubtitle');
    if (section === 'constraints') {
      heroTitle.textContent    = 'SV Constraints';
      heroSubtitle.textContent = 'Practice real-world constraint programming questions, Intel/NVIDIA interview scenarios, and puzzle solvers. Mark questions complete as you solve them.';
    } else {
      heroTitle.textContent    = 'Fork-Join Concurrency';
      heroSubtitle.textContent = 'Master concurrency brainteasers, multi-threading synchronisation, semaphore barriers, and process dependency graphs in SystemVerilog.';
    }

    // Reset filter pills to "all"
    currentFilter = 'all';
    filterPills.forEach(p => p.classList.toggle('active', p.dataset.filter === 'all'));

    searchInput.value = '';
    searchQuery = '';
    applyFilters();
    updateStats();
  }

  sectionConstraintsBtn.addEventListener('click', () => setSection('constraints'));
  sectionForkJoinBtn.addEventListener('click',    () => setSection('forkjoin'));

  // ─── UI reactive state ────────────────────────────────────────────────────────
  let currentFilter = 'all';
  let searchQuery   = '';
  let activeModalQuestionId = null;
  let filteredQuestions = [];

  // ─── DOM refs ─────────────────────────────────────────────────────────────────
  const questionsListEl    = document.getElementById('questionsList');
  const emptyStateEl       = document.getElementById('emptyState');
  const searchInput        = document.getElementById('searchInput');
  const searchClearBtn     = document.getElementById('searchClear');
  const filterPills        = document.querySelectorAll('.filter-pill');
  const toggleAllBtn       = document.getElementById('toggleAllBtn');
  const resetBtn           = document.getElementById('resetBtn');
  const progressRatioEl    = document.getElementById('progressRatio');
  const progressBarFillEl  = document.getElementById('progressBarFill');
  const freqProgressStatEl = document.getElementById('freqProgressStat');
  const modalOverlay       = document.getElementById('modalOverlay');
  const modalCloseBtn      = document.getElementById('modalCloseBtn');
  const modalTitle         = document.getElementById('modalTitle');
  const modalTags          = document.getElementById('modalTags');
  const modalDescText      = document.getElementById('modalDescText');
  const modalCode          = document.getElementById('modalCode');
  const modalFilename      = document.getElementById('modalFilename');
  const modalGithubLink    = document.getElementById('modalGithubLink');
  const modalCompleteChk   = document.getElementById('modalCompleteCheckbox');
  const copyCodeBtn        = document.getElementById('copyCodeBtn');
  const modalPrevBtn       = document.getElementById('modalPrevBtn');
  const modalNextBtn       = document.getElementById('modalNextBtn');
  const toggleCodeBtn      = document.getElementById('toggleCodeBtn');
  const toggleCodeText     = document.getElementById('toggleCodeText');
  const toggleCodeIcon     = document.getElementById('toggleCodeIcon');
  const codeWrapper        = document.getElementById('codeWrapper');

  // ─── Helper: active question pool ────────────────────────────────────────────
  function activePool() {
    return activeSection === 'constraints' ? constraintQs : forkjoinQs;
  }

  // ─── Persist ─────────────────────────────────────────────────────────────────
  function saveCompleted() {
    try { localStorage.setItem(STORAGE_KEY, JSON.stringify(Array.from(completedSet))); } catch(e) {}
    updateStats();
  }

  function saveCollapsed() {
    try { localStorage.setItem(COLLAPSED_KEY, JSON.stringify(Array.from(collapsedSet))); } catch(e) {}
  }

  // ─── Stats ───────────────────────────────────────────────────────────────────
  function updateStats() {
    const pool = activePool();
    const total = pool.length;
    const completedCount = pool.filter(q => completedSet.has(q.id)).length;
    const pct = total > 0 ? Math.round((completedCount / total) * 100) : 0;

    if (progressRatioEl) progressRatioEl.textContent = `${completedCount} / ${total} (${pct}%)`;
    if (progressBarFillEl) progressBarFillEl.style.width = `${pct}%`;

    const freqQs = pool.filter(q => q.isFrequentlyAsked);
    const freqDone = freqQs.filter(q => completedSet.has(q.id)).length;
    if (freqProgressStatEl) freqProgressStatEl.textContent = `${freqDone} / ${freqQs.length} Frequently Asked Solved`;

    const pillAll  = document.querySelector('[data-filter="all"] .pill-count');
    const pillFreq = document.querySelector('[data-filter="frequent"] .pill-count');
    const pillTodo = document.querySelector('[data-filter="todo"] .pill-count');
    const pillDone = document.querySelector('[data-filter="completed"] .pill-count');
    if (pillAll)  pillAll.textContent  = total;
    if (pillFreq) pillFreq.textContent = freqQs.length;
    if (pillTodo) pillTodo.textContent = total - completedCount;
    if (pillDone) pillDone.textContent = completedCount;

    // Update section tab counts
    const constraintsCountEl = document.getElementById('constraintsCount');
    const forkjoinCountEl    = document.getElementById('forkjoinCount');
    if (constraintsCountEl) constraintsCountEl.textContent = constraintQs.length;
    if (forkjoinCountEl)    forkjoinCountEl.textContent    = forkjoinQs.length;

    // Update top nav badge = total across both
    const navBadge = document.querySelector('#navCodingTab .nav-tab-badge');
    if (navBadge) navBadge.textContent = allQuestions.length;
  }

  // ─── Filters ──────────────────────────────────────────────────────────────────
  function applyFilters() {
    const pool = activePool();
    const qLower = searchQuery.trim().toLowerCase();

    filteredQuestions = pool.filter(item => {
      const matchSearch = !qLower ||
        item.title.toLowerCase().includes(qLower) ||
        item.description.toLowerCase().includes(qLower) ||
        item.path.toLowerCase().includes(qLower) ||
        item.tags.some(t => t.toLowerCase().includes(qLower));
      if (!matchSearch) return false;

      if (currentFilter === 'frequent')  return item.isFrequentlyAsked;
      if (currentFilter === 'todo')      return !completedSet.has(item.id);
      if (currentFilter === 'completed') return completedSet.has(item.id);
      return true;
    });

    renderQuestions();
  }

  // ─── Render ───────────────────────────────────────────────────────────────────
  function renderQuestions() {
    questionsListEl.innerHTML = '';

    if (filteredQuestions.length === 0) {
      emptyStateEl.style.display = 'block';
      return;
    }
    emptyStateEl.style.display = 'none';

    // Group by category
    const byCategory = new Map();
    filteredQuestions.forEach(q => {
      if (!byCategory.has(q.category)) byCategory.set(q.category, []);
      byCategory.get(q.category).push(q);
    });

    byCategory.forEach((questions, categoryName) => {
      const isCollapsed = collapsedSet.has(categoryName);
      const done  = questions.filter(q => completedSet.has(q.id)).length;
      const total = questions.length;
      const pct   = total > 0 ? Math.round((done / total) * 100) : 0;

      const section = document.createElement('section');
      section.className = `category-section glass-panel ${isCollapsed ? 'collapsed' : ''}`;
      section.dataset.category = categoryName;

      section.innerHTML = `
        <div class="category-header">
          <div class="category-header-left">
            <svg class="category-chevron" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
            <h2 class="category-title">${categoryName}</h2>
          </div>
          <div class="category-header-right">
            <div class="category-progress-pill">
              <span>${done} / ${total}</span>
              <div class="category-mini-bar"><div class="category-mini-fill" style="width:${pct}%"></div></div>
            </div>
          </div>
        </div>
        <div class="category-content">
          <table class="questions-table">
            <tbody>${questions.map(q => rowHTML(q)).join('')}</tbody>
          </table>
        </div>
      `;

      section.querySelector('.category-header').addEventListener('click', () => {
        section.classList.toggle('collapsed');
        if (section.classList.contains('collapsed')) collapsedSet.add(categoryName);
        else collapsedSet.delete(categoryName);
        saveCollapsed();
      });

      questionsListEl.appendChild(section);
    });

    attachRowListeners();
  }

  function tagBadge(t) {
    let cls = 'tag-generic';
    if (t === 'Frequently Asked') cls = 'tag-freq';
    else if (t === 'Intel')  cls = 'tag-intel';
    else if (t === 'NVIDIA') cls = 'tag-nvidia';
    else if (t === 'Apple')  cls = 'tag-apple';
    return `<span class="tag-badge ${cls}">${t === 'Frequently Asked' ? '★ ' + t : t}</span>`;
  }

  function rowHTML(q) {
    const checked = completedSet.has(q.id);
    const tagsHtml = q.tags.map(t => tagBadge(t)).join('');

    return `
      <tr class="question-row ${checked ? 'completed' : ''}" data-id="${q.id}">
        <td class="cell-status">
          <label class="custom-checkbox">
            <input type="checkbox" data-id="${q.id}" ${checked ? 'checked' : ''} />
            <div class="checkbox-mark">
              <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round">
                <polyline points="20 6 9 17 4 12"></polyline>
              </svg>
            </div>
          </label>
        </td>
        <td class="cell-title">
          <div class="question-title-wrap" data-id="${q.id}">
            <span class="question-title">${q.title}</span>
          </div>
        </td>
        <td class="cell-tags">${tagsHtml}</td>
        <td class="cell-actions">
          <button class="view-code-btn" data-id="${q.id}">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <polyline points="16 18 22 12 16 6"></polyline><polyline points="8 6 2 12 8 18"></polyline>
            </svg>
            Code
          </button>
        </td>
      </tr>`;
  }

  function attachRowListeners() {
    document.querySelectorAll('.custom-checkbox input').forEach(cb => {
      cb.addEventListener('change', e => {
        const id  = e.target.dataset.id;
        const row = document.querySelector(`.question-row[data-id="${id}"]`);
        if (e.target.checked) {
          completedSet.add(id);
          if (row) row.classList.add('completed');
          showToast('Marked as completed!');
        } else {
          completedSet.delete(id);
          if (row) row.classList.remove('completed');
        }
        saveCompleted();
        if (activeModalQuestionId === id && modalCompleteChk) {
          modalCompleteChk.checked = e.target.checked;
        }
        updateCategoryBars();
      });
    });

    document.querySelectorAll('.question-title-wrap, .view-code-btn').forEach(btn => {
      btn.addEventListener('click', () => openModal(btn.dataset.id));
    });
  }

  function updateCategoryBars() {
    document.querySelectorAll('.category-section').forEach(sec => {
      const rows  = sec.querySelectorAll('.question-row');
      const done  = sec.querySelectorAll('.question-row.completed').length;
      const total = rows.length;
      const pct   = total > 0 ? Math.round((done / total) * 100) : 0;
      const countSpan = sec.querySelector('.category-progress-pill span');
      const barFill   = sec.querySelector('.category-mini-fill');
      if (countSpan) countSpan.textContent = `${done} / ${total}`;
      if (barFill)   barFill.style.width   = `${pct}%`;
    });
  }

  // ─── Modal ───────────────────────────────────────────────────────────────────
  function openModal(id) {
    // Search across all questions so hash links always resolve
    const q = allQuestions.find(item => item.id === id);
    if (!q) return;
    activeModalQuestionId = id;

    modalTitle.textContent    = q.title;
    modalFilename.textContent = q.path;
    modalDescText.textContent = q.explanation || q.description;
    modalGithubLink.href = `https://github.com/bvsnithin/hardware-interview-prep/blob/main/${q.path}`;
    modalCompleteChk.checked = completedSet.has(q.id);

    modalTags.innerHTML = q.tags.map(t => tagBadge(t)).join('');

    modalCode.textContent = q.code;
    modalCode.className   = 'language-verilog';

    // Default code wrapper to hidden
    resetCodeToggleState();

    const idx = filteredQuestions.findIndex(item => item.id === id);
    modalPrevBtn.disabled = idx <= 0;
    modalNextBtn.disabled = idx < 0 || idx >= filteredQuestions.length - 1;

    resetCopyBtn();
    modalOverlay.classList.add('active');
    document.body.style.overflow = 'hidden';
    window.location.hash = `q=${id}`;
  }

  function resetCodeToggleState() {
    if (!codeWrapper || !toggleCodeBtn) return;
    codeWrapper.classList.add('hidden');
    toggleCodeBtn.classList.remove('active');
    if (toggleCodeText) toggleCodeText.textContent = 'Show Code Solution';
    if (toggleCodeIcon) {
      toggleCodeIcon.innerHTML = `
        <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
        <circle cx="12" cy="12" r="3"></circle>`;
    }
  }

  if (toggleCodeBtn) {
    toggleCodeBtn.addEventListener('click', () => {
      const isHidden = codeWrapper.classList.contains('hidden');
      if (isHidden) {
        codeWrapper.classList.remove('hidden');
        toggleCodeBtn.classList.add('active');
        toggleCodeText.textContent = 'Hide Code Solution';
        toggleCodeIcon.innerHTML = `
          <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
          <line x1="1" y1="1" x2="23" y2="23"></line>`;
        if (window.Prism) Prism.highlightElement(modalCode);
      } else {
        resetCodeToggleState();
      }
    });
  }

  function closeModal() {
    modalOverlay.classList.remove('active');
    document.body.style.overflow = '';
    activeModalQuestionId = null;
    history.replaceState(null, null, ' ');
  }

  function resetCopyBtn() {
    copyCodeBtn.innerHTML = `
      <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect>
        <path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path>
      </svg>
      Copy Code`;
  }

  modalCloseBtn.addEventListener('click', closeModal);
  modalOverlay.addEventListener('click', e => { if (e.target === modalOverlay) closeModal(); });

  modalCompleteChk.addEventListener('change', () => {
    if (!activeModalQuestionId) return;
    const isChecked = modalCompleteChk.checked;
    const rowCb = document.querySelector(`.custom-checkbox input[data-id="${activeModalQuestionId}"]`);
    if (rowCb) {
      rowCb.checked = isChecked;
      rowCb.dispatchEvent(new Event('change'));
    } else {
      if (isChecked) completedSet.add(activeModalQuestionId);
      else completedSet.delete(activeModalQuestionId);
      saveCompleted();
    }
  });

  copyCodeBtn.addEventListener('click', () => {
    const q = allQuestions.find(item => item.id === activeModalQuestionId);
    if (!q) return;
    navigator.clipboard.writeText(q.code).then(() => {
      copyCodeBtn.innerHTML = `
        <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
          <polyline points="20 6 9 17 4 12"></polyline>
        </svg>
        Copied!`;
      setTimeout(resetCopyBtn, 2000);
    });
  });

  modalPrevBtn.addEventListener('click', () => {
    const idx = filteredQuestions.findIndex(q => q.id === activeModalQuestionId);
    if (idx > 0) openModal(filteredQuestions[idx - 1].id);
  });

  modalNextBtn.addEventListener('click', () => {
    const idx = filteredQuestions.findIndex(q => q.id === activeModalQuestionId);
    if (idx >= 0 && idx < filteredQuestions.length - 1) openModal(filteredQuestions[idx + 1].id);
  });

  // ─── Search ───────────────────────────────────────────────────────────────────
  searchInput.addEventListener('input', e => { searchQuery = e.target.value; applyFilters(); });
  searchClearBtn.addEventListener('click', () => {
    searchInput.value = '';
    searchQuery = '';
    applyFilters();
    searchInput.focus();
  });

  // ─── Filter pills ─────────────────────────────────────────────────────────────
  filterPills.forEach(pill => {
    pill.addEventListener('click', () => {
      filterPills.forEach(p => p.classList.remove('active'));
      pill.classList.add('active');
      currentFilter = pill.dataset.filter;
      applyFilters();
    });
  });

  // ─── Toggle all collapse ──────────────────────────────────────────────────────
  let allCollapsed = false;
  toggleAllBtn.addEventListener('click', () => {
    allCollapsed = !allCollapsed;
    document.querySelectorAll('.category-section').forEach(sec => {
      const cat = sec.dataset.category;
      if (allCollapsed) { sec.classList.add('collapsed'); collapsedSet.add(cat); }
      else              { sec.classList.remove('collapsed'); collapsedSet.delete(cat); }
    });
    toggleAllBtn.textContent = allCollapsed ? 'Expand All' : 'Collapse All';
    saveCollapsed();
  });

  // ─── Reset progress ───────────────────────────────────────────────────────────
  resetBtn.addEventListener('click', () => {
    if (confirm('Reset all completed progress?')) {
      completedSet.clear();
      saveCompleted();
      applyFilters();
      showToast('Progress reset.');
    }
  });

  // ─── Top-level nav tabs ───────────────────────────────────────────────────────
  const navCodingTab = document.getElementById('navCodingTab');
  const navBankTab   = document.getElementById('navBankTab');
  const codingView   = document.getElementById('codingView');
  const bankView     = document.getElementById('bankView');

  navCodingTab.addEventListener('click', () => {
    navCodingTab.classList.add('active');
    navBankTab.classList.remove('active');
    codingView.style.display = '';
    bankView.classList.remove('active');
  });

  navBankTab.addEventListener('click', () => {
    navBankTab.classList.add('active');
    navCodingTab.classList.remove('active');
    codingView.style.display = 'none';
    bankView.classList.add('active');
  });

  // ─── Keyboard shortcuts ───────────────────────────────────────────────────────
  document.addEventListener('keydown', e => {
    if (e.key === 'Escape' && modalOverlay.classList.contains('active')) {
      closeModal();
    } else if (e.key === '/' && document.activeElement !== searchInput && !modalOverlay.classList.contains('active')) {
      e.preventDefault();
      searchInput.focus();
    } else if (modalOverlay.classList.contains('active')) {
      if (e.key === 'ArrowLeft' && !modalPrevBtn.disabled) modalPrevBtn.click();
      if (e.key === 'ArrowRight' && !modalNextBtn.disabled) modalNextBtn.click();
    }
  });

  // ─── Toast ────────────────────────────────────────────────────────────────────
  function showToast(message) {
    let toast = document.getElementById('toastNotification');
    if (!toast) {
      toast = document.createElement('div');
      toast.id = 'toastNotification';
      toast.className = 'toast';
      document.body.appendChild(toast);
    }
    toast.textContent = message;
    toast.classList.add('show');
    setTimeout(() => toast.classList.remove('show'), 2400);
  }

  // ─── Init ─────────────────────────────────────────────────────────────────────
  setSection(activeSection);  // Renders the saved section + calls updateStats + applyFilters

  // Handle URL hash links
  const hash = window.location.hash;
  if (hash.startsWith('#q=')) {
    const id = hash.replace('#q=', '');
    // Switch to the right section first
    if (forkjoinQs.some(q => q.id === id))    setSection('forkjoin');
    else if (constraintQs.some(q => q.id === id)) setSection('constraints');
    if (allQuestions.some(q => q.id === id)) openModal(id);
  }
});
