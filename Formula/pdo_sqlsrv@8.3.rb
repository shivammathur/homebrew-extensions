# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "b64012d998388684161e7fb2f70764d8a37159f64a6036b68a5def5e855ca8ee"
    sha256 cellar: :any, arm64_sequoia: "762a9db2324fc440a595418aed8e5a06f5225c4ca608b16a51914e5f25c784eb"
    sha256 cellar: :any, arm64_sonoma:  "a484b64304ef42b00c9645777733fdecb954be104bb6a67e67d0d776def6f341"
    sha256 cellar: :any, sonoma:        "98208592a62eaba568a714b8862def806201ccd966e0f56ddf4c8cc4323c3b09"
    sha256 cellar: :any, arm64_linux:   "958c345f88f23d096fe99b347f69518b958e5bfc733a75dc561713fcd90c2bad"
    sha256 cellar: :any, x86_64_linux:  "b3b007400671b0ca46dd3ff40cc2b0c1f0f0ca423752aeb385c82a536dd10830"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "pdo_sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-pdo_sqlsrv"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
