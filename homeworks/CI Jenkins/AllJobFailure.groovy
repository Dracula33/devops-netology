Jenkins.instance.getAllItems(Job.class).each{
  job_name = it.name
  job_builds = it.getBuilds()
  for(i = 0; i < job_builds.size(); i++ ){
    if (job_builds[i].result.toString() == 'FAILURE'){
      println("JOB $job_name BUILD ${job_builds[i].number} is FAILED")
      break
    }
  }
}
println()
