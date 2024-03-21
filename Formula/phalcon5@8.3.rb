# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.2.tgz"
  sha256 "1b07edf639177ae3491d0fd8f223193c65f38870b621572f7d5465ca81ae2ac7"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "643fc5e0abc025e9bfce9dd1b51a34a9de199e4c098c5d4eefc9a834cf247cb8"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "63cba6722cf42122216252fea98f34f0659374c56797a82b278b1b7ce4af4f59"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7d99f95e5ac7315d2d138e2beee72e7c850b4ac815685dad4848869c3d679bce"
    sha256 cellar: :any_skip_relocation, ventura:        "e6ad6bb2a92ba12b198b9fc8d3b35dca05185ac76304bd2f09d094e31e345e59"
    sha256 cellar: :any_skip_relocation, monterey:       "3b35a9af48df332ef64f155c72e7fec89fda549c247c7105cbd6b6db579c9ce3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "57271d1ec54155e71fd02498bfb07a4745736e24ed370d9c80e3ba92edb757b2"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
