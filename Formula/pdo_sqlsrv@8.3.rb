# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo_sqlsrv Extension
class PdoSqlsrvAT83 < AbstractPhpExtension
  init
  desc "pdo_sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/pdo_sqlsrv-5.10.1.tgz"
  sha256 "c7854196a236bc83508a346f8c6ef1df999bc21eebbd838bdb0513215e0628ad"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "ec63f1380b163dd47874f3d7f141fbe37dfeeb568f0852796da8aaa1a01db709"
    sha256 cellar: :any,                 arm64_big_sur:  "31ec2942c777d878229aafad3d6e634734a4dd02f34b7c36421428cfa2ff944e"
    sha256 cellar: :any,                 monterey:       "1785c6e6fbc2dbb5537aa7d0439a3a11a2a429b926416742ed7b7413175917d4"
    sha256 cellar: :any,                 big_sur:        "b29867062e77606af7f9697cda09dc8be29f85071b90c6426b684e9a47b7882f"
    sha256 cellar: :any,                 catalina:       "e5b936cc7b40faa037a22dc0be9ef21b2f2d28dca478a8a76a739c6c2cc9d40d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c892fe6afe07a72ccf87bd05f6383ee3a32686754b776f9706b9b99fc300140e"
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
