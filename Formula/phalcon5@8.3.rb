# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.22.0.tgz"
  sha256 "da783fc9157cff533aa6f44f01134237fa1542c1310cbd06299340d4a6252979"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "598d345f5ec4559be70830d0c0eb2d69d6b7e55eeee7f39a36b35f43b8241cd1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "be0dfb9629bff8d963e6d8e2edab827490ae1a74cd53242b0ddb47eb8be2058e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "33a546a5e3d25d66adb49e7cc6dc6a56ddd60bd6fc29f4c5bb3096c6ac218336"
    sha256 cellar: :any,                 arm64_linux:       "e7329faab28ad64a109b59b3d0ccdb3954b8890fdade6cbd0bab6f89eb981797"
    sha256 cellar: :any,                 x86_64_linux:      "0455fd5c59d3ba5a82b5183f7a9035b98d16045d3ccd14ad20cc846e5e8715ef"
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
