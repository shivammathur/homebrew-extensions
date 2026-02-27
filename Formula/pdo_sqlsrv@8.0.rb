# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT80 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.13.0.tgz"
  sha256 "efa859bcc48d97f25268dbdebf1db25f25610d7fa36b3ee91073c1c99411e24c"
  head "https://github.com/Microsoft/msphpsql.git", branch: "dev"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/pdo_sqlsrv/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "a9664fedcefc57fbd3a9f1e2fd4f50ee649ce1fff50c053e910f7babaf75255d"
    sha256 cellar: :any,                 arm64_sequoia: "c928fed8ddfb04c4bbef5ef650490b8a81e3a6ee9b08afe18eb272e28f947f9d"
    sha256 cellar: :any,                 arm64_sonoma:  "a580e5f8688c8e7ffb6b9d65005691d776944ed8ef6bdd74508e24126b54a161"
    sha256 cellar: :any,                 sonoma:        "22d17714c8001257aa8307339fe058948ab0a583837f0b7f945532c68e23ab65"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "cc90ce4eca1e2c034a0daafb416f967afe15af20652012556e02b583277a0750"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9ce5776e27b66cc8e952ca1a06b42b146ea8c1cceb77d0ff6d8256093460a9f7"
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
