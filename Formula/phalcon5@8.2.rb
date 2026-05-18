# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.13.0.tgz"
  sha256 "5dc5dbaa50a397930557cbd0570e9c7769000f5e1675535e58cc7f451cf490e3"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6c3cd7851131d241e8f06132d00b3b8744035719ce0e492e860a11100b23094f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2a2da9257674823e1ff610e7a5fe3a595e64a0c4abb8b872b9539a0c9c9a0b6e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2d48a1f5a61ecd2d4acacfa85312a696d4529d1d959ce948076a9fb3456ac11a"
    sha256 cellar: :any_skip_relocation, sonoma:        "e234f9656b99c0e1ef3a750853f96b73fed346e410e6fdc685d011c3cac11e8c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0ab468028569a2b5b3d9993e17a1e59d48a52a843a7ac55122dc09199606fa49"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "893631f6a19fea48408b5188f2cb8b79fd949f7f0da8792375aeb628a8f60662"
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
