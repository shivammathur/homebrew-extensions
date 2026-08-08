# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT84 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.3.tgz"
  sha256 "198a7b37da0658d36a93d158a0ec179b137b3a4d241c90a6650ae9ee8f91ec4a"
  head "https://github.com/Microsoft/msphpsql.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "c7c04682ffe1c790a647736127479f90e346e8172213fcaede6ec44f1dbd2d6a"
    sha256 cellar: :any, arm64_sequoia: "10d102ba3c2f329fdae0539a54c9cace8b3ce2f898ba1f8e141bbaf5eb6a83d1"
    sha256 cellar: :any, arm64_sonoma:  "f68dd210823d12ba5eb15bc1f548e388db5333c351e25b82da99a3493ffcace9"
    sha256 cellar: :any, sonoma:        "63d33e0dff943d2db3bb53f44858e01263167f27dc320f026bdc5713d6699ac0"
    sha256 cellar: :any, arm64_linux:   "7ca2d29c9bd3badd092f94dbb5d01a3db2b48ba239c517a28251280a8764df52"
    sha256 cellar: :any, x86_64_linux:  "b10189a28901534881706d623ecdb14df42280ded83e184fb75b39e315748046"
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
