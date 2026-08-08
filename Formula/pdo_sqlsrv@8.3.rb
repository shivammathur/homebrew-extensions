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
    sha256 cellar: :any, arm64_tahoe:   "d0824fbd1f60e455d7aca1ec2d4479daa6e8ea804d19afa7436b4d8f39ade6d7"
    sha256 cellar: :any, arm64_sequoia: "ef62a4ac0f56ba4b9b7c730eee354a9176395f6aa8d8cb09324801579a63b3bc"
    sha256 cellar: :any, arm64_sonoma:  "35579e157b70ab1113ae58366c4be52aaab9544b1a3528261c4ee471b7ec8fee"
    sha256 cellar: :any, sonoma:        "9f3756aeb729b9c94e7c7eee4e2998fb5dc36434207c43344174482b6d34fb9c"
    sha256 cellar: :any, arm64_linux:   "6709d4bd692dbedc213e720fa33319a314048ae6cba6617f50a3cf8edad52522"
    sha256 cellar: :any, x86_64_linux:  "5c85f255960747e367412cbb1ac3169337f8887bb7ba7a807ffe6b0511a89bd4"
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
