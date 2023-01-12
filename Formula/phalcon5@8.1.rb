# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.4.tgz"
  sha256 "313aeb79611587776d0f56dc7ee0d713ebbb19abb4c79b38f1cb1145913ea374"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "598a6ad65d47f51389d36e87039358bb3db47b49713f8951006ad6fef088109e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c2ba6b7dcf775f8d9b117f30f264981473121c945777db855c376c714b0a3e5b"
    sha256 cellar: :any_skip_relocation, monterey:       "f26747cf731b48fb375c8c458fa9d87f4651e9269942b1e7d8922a4c03e2ff95"
    sha256 cellar: :any_skip_relocation, big_sur:        "95e42b74b7c9369c30d1b10fbaeb7ace6d4e8899c22407d2bb61e318186081e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "940aff63543aa582d3adb78a462d09626b46aa39a73de3ac7442cb1aa0bc5c4c"
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
