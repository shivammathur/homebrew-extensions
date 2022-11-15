# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT71 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "e043b655f4019b45a578033e22c3a879dcd44413275d411439de809ff8485d37"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c1c7f2573bc1b30aacbad3d03bb5756ced54479cc4d5f92f37645a50b2737b51"
    sha256 cellar: :any_skip_relocation, monterey:       "464d616b6790120a43c187487e1bed4b3ce2227f5c30a75a6179b9a66efa79ba"
    sha256 cellar: :any_skip_relocation, big_sur:        "5979bc35365f67ddd3453a10ccffcaf90064f9004abb3a1c370fbe536b202f3e"
    sha256 cellar: :any_skip_relocation, catalina:       "71d2345bb321b4faca9103246d4ef8bb833c8114a69535ce8806ad5911033047"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "66243c4eda2dd0ba3340e517025a9c7eee8d04d36d3f10530fad4d0d8a92bfb8"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
