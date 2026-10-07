# Hardware Interview Prep

🌐 **Live site →** [https://bvsnithin.github.io/hardware-interview-prep/](https://bvsnithin.github.io/hardware-interview-prep/)

> Question tracker with code viewer, progress tracking, and company tags.

This is a comprehensive repository of RTL design, SystemVerilog constraints, coverage models, and interview preparation materials for hardware design verification and RTL engineering roles.

## My 2 Cents on Preparing for Interviews

This guide is split into two sections: one for **internships** and one for **new grad roles**. At the time of writing, the job market for hardware engineers in digital front-end VLSI is pretty good. The roles I mean are RTL design engineer, design verification (DV) engineer, and physical design engineer. I don't have much experience with physical design myself, but I see people in my university getting interview calls and offers for it. I can't say how the market or the industry will look in the future.
 
If you are a sophomore, junior, or first-year master's student, the internship section is for you. If you are in your graduating year (senior or second-year master's), skip ahead to the new grad section.
 
## Internships
 
If you are preparing for RTL design, FPGA, or design verification roles and you are in your early years of university, starting early is very important.
 
**Build strong foundations.** Start with digital electronics (ECEN 248 for TAMU students). A thorough understanding of how digital circuits work will support every future course you take. Next, build your computer organization and architecture skills (ECEN/CSCE 350, CSCE 614, CSCE 410/611, ECEN 469 for TAMU students). For internships you might not need to know how a superscalar processor works (would be great if you could explain how modern CPUs work or the out of order processing), but understanding caches and basic pipelining is absolutely important.
 
**Join a research lab as soon as you can.** Learn from the senior students, master's students, and PhD students. Many of them have already interned or worked in industry, so the connections you build will be immensely helpful. Being close to them and to your professors opens doors to interviews. I have seen professors help their PhD and lab students get internship and full-time calls. Don't be scared of it. Build your basics in class and work on practical projects in the lab. Even one hour a week with the grad students can do a lot for your learning, because they are among the best resources you will have.
 
**Don't neglect programming.** Although AI can write great code, you still need to handle basic programming to clear interviews. At the time of writing, companies still ask programming questions, and being able to write code versus not being able to could be the point of difference. Don't let that be you. Solve problems consistently to develop your problem-solving skills. LeetCode and other competitive programming platforms are still relevant for data structures and algorithms, and some of those topics form the foundation for real hardware concepts, such as LRU and LFU policies for cache replacement.
 
**Be aware of AI.** Learn how to use AI tools, and don't live under a rock. Learn how AI hardware works too. Research labs and grad students can help you a lot here.
 
**Do projects outside of coursework.** This is how you stand out from your classmates, and it is another reason to be part of a lab. Always document your work somewhere visible, like GitHub or LinkedIn.
 
**Apply early and use your network.**
 
**Once you get the interview call,** refer to your documented notes and your coursework. Intern interviews are never a question mark. They are the toughest to land, but the easiest to predict, because they draw almost entirely from what you learned in class. You can use this repo to look at sample questions and as a refresher if you are preparing for design verification interviews. The first internship is always the hardest to get, but once you land one at a good company, it opens doors to many more calls for future internships and new grad roles.
 
## New Grad
 
If you have completed an internship at a prominent company, you will most likely get a return offer(you will, right? But this is most of the times out of your control because of various reasons). The internship also puts a strong brand on your resume, which helps you land future internships in your senior years or a new grad role.
 
I feel new grad interviews are easier than internship interviews, because now it's all about being the best salesperson. Say you interned as a DV engineer at AMD. Your resume carries the AMD brand, and recruiters and hiring managers almost always ask you to talk about your previous experience. If you did significant work there, this is your chance to pitch yourself. The technical part is no different from internship interviews, but your room for error is smaller. Still, with a few months of real industry experience behind you, you have likely grown technically stronger as well. So clearing the technical rounds should be a piece of cake (not really, but a lot easier than it was a year ago).
 
This is why internship experience matters so much for new grad roles. But I know landing an internship is not always easy. If that happens, keep building on your research lab experience. Publishing a paper or two with the grad students during summers when you couldn't intern will put you on the map. The presentations you give and the conferences you attend will also help you connect with people in industry.
 
As you approach your senior year, you are also expected to be good with computer architecture and advanced verification methodologies like UVM. Do as many projects as you can in these areas, and keep building your problem-solving and programming skills in C++, C, or Python.
 
## Final Words
 
Use this repo to find real interview questions and topic refreshers. All the best with your interview prep and job search. I hope you land something soon, and something great. Always strive to be the best engineer you can be, and most importantly, learn to have fun. After all, you chose to be in the amazing world of electrical and computer engineering, where the applications are truly limitless.

Do reach out to me on [LinkedIn](https://www.linkedin.com/in/nithin-bazaru/) if this repo was helpful!

---

## Repository Structure

### Folders Overview

#### rtl - Register Transfer Level Designs
Contains foundational RTL implementations

#### constraints - SystemVerilog Constraints & Problems
A collection of SystemVerilog constraint programming exercises for randomization-based verification. 

For detailed list of constraint problems, check the [constraints/README.md](constraints/README.md) file.

#### coverage - Functional Coverage Models
Coverage scenarios

#### assertions - SystemVerilog Assertions
Assertion implementations/scenarios

#### scripting - Basics of Python and Perl 
Nothing major here yet. :')

---

## Getting Started

### Running Simulations

If you are from Texas A&M University, College station and have access to olympus server, execute the setup.bash script to initialize your environment:
```bash
./setup.bash
```

Note: Make sure to run the following Slurm command before executing the bashscript:
```bash
load-csce-616
```

If you don't want X11 forwarding (Case where you are running the terminal from vscode instead of MobaXterm on your windows), make sure to run the following command instead:
```bash
srun \
  --job-name=csce-616 \
  --cpus-per-task=1 \
  --partition=academic \
  --qos=olympus-academic \
  --pty \
  bash -l
```

## Notes
Use xrun command for Xcelium simulations and refer to each folder's documentation for specific details.

## Where to Start From

Depending on the role you are targeting and the time you have before your interview, follow these curated study paths:

### Track 1: Design Verification (DV) Engineer Roadmap

If you are interviewing for **ASIC/SoC Verification**, **DV Engineer**, or **Emulation** roles:

1. **Phase 1: SystemVerilog Core & Concurrency**
   - Start at [system_verilog/README.md](system_verilog/README.md).
   - Master the IEEE 1800 **Stratified Event Queue** (`system_verilog/regions/`) to understand Active, NBA, and Observed regions.
   - Practice the concurrency brainteasers in `system_verilog/fork_join/` (e.g., `automatic_fork_join.sv`, `parallel_dependency_graph.sv`, and `scenario_2.sv`).
   - Review data structures: dynamic arrays, associative arrays, and queues in `arrays.sv`.

2. **Phase 2: Constrained-Random Verification (CRV)**
   - Move to [constraints/README.md](constraints/README.md).
   - Start with real interview questions in `constraints/intel_questions/` and `constraints/scenarios/` (TLB eviction, FIFO stimulus, virtual address alignment).
   - Progress to tricky puzzles: `eight_queens_constraint.sv`, `sudoku.sv`, `implement_randc.sv`, and `unique_2d_array.sv`.

3. **Phase 3: SVA Assertions & Functional Coverage**
   - Study Assertions in SystemVerilog
   - Study Coverage: Understand covergroups, transition bins, cross coverage, and illegal vs. ignore bins.

4. **Phase 4: UVM Architecture & Testbench Design**
   - Master top interview topics:
     - `uvm_config_db/` (virtual interface propagation and debugging).
     - `analysis_port/` and `analysis_port_fifo/` (1-to-many broadcasting vs. decoupled FIFO consumption).
     - `objection/` (phase objection mechanism and drain times).
     - `override/` (factory type overrides).
     - `leetsilicon_scenario_based/` (out-of-order scoreboard matching and split-beat drivers).

5. **Phase 5: EDA Automation & Coding Rounds**
   - Review [scripting](scripting/) for simulation log parsing and regex error extraction.
   - Review [leetcode/README.md](leetcode/README.md), focusing primarily on the **Bit Manipulation** section.

---

### Track 2: RTL & Digital IC Design Engineer Roadmap

If you are interviewing for **RTL Design**, **Digital ASIC Engineer**, or **FPGA Design** roles:

1. **Phase 1: Foundational Combinational & Arithmetic Logic**

2. **Phase 2: Clock Dividers & Frequency Generators**

3. **Phase 3: FSMs & Sequential Control Logic**

4. **Phase 4: Clock Domain Crossing (CDC)**

5. **Phase 5: Arbitration & Buffering (FIFO)**

6. **Phase 6: Hardware-Oriented Coding Rounds**

