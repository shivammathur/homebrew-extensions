# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT86 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.1.tgz"
  sha256 "350a5d66a13be11fadff6eb0d7391e58c1b8af2cd0abe141263f5af1930feb69"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "34b2f9f230facde937a181aaf22c3fa7694aeade64c55c6547dd0d8f9d325377"
    sha256 cellar: :any,                 arm64_sequoia: "b9f3c0a73e55d1d15a7cf2ade34699170e4fd136da2bf45d5a8157f2eb5babf5"
    sha256 cellar: :any,                 arm64_sonoma:  "26cd1162baf7c0a71f069df6445d14e94c1536a59c3a90e8c01427c64b242a6e"
    sha256 cellar: :any,                 sonoma:        "66fc16ee03d5b79a8dc2385a6e244822e246cdb06f22899fe6daa6a1e3a6284c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a4fc18a651e7d63bc5174a67bcd2fb30694037f3972079edb618dc6fe1bdb8e2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5adff7f2019ada755827fcf1b07253e9a274f81254c54345ab1badcf456ce637"
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
