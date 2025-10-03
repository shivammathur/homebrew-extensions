# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class XhprofAT86 < AbstractPhpExtension
  init
  desc "Hierarchical Profiler for PHP"
  homepage "https://github.com/longxinH/xhprof"
  url "https://pecl.php.net/get/xhprof-2.3.10.tgz"
  sha256 "251aee99c2726ebc6126e1ff0bb2db6e2d5fd22056aa335e84db9f1055d59d95"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/xhprof/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "93c77f57c60c765fb2c40d5494fb91d06f2518bd7ffe817f3e4bdf55bd3ba2ed"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9a84c946f34235b7f0b233840e9658d4d262fd4ae0d8126db1e755b70959f82a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2cc28e055d09a6cc92815b0f000c5462baacf286103e04333c72c3a5a06214df"
    sha256 cellar: :any_skip_relocation, sonoma:        "36b128c438c9e9504ad98833d954d0fcf8c31ce0a08d2fe7f58af0c972490d51"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3e024e4c624793f82ede2923a265a68f8ce970b58afbd9f2619e2198a157140c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb07b76155f5ee97635d303da52e0082424544346882f1f128bbf77a39e02d4c"
  end

  def install
    Dir.chdir "xhprof-#{version}/extension"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xhprof"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
