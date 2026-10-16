# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.23.0.tgz"
  sha256 "34738f486ac6ade23b70c4b5b4d8292b5fda3b334ea119b6b35dbcfab24df50d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d89ace90fba2d26306d68dd9c424f785514485ad1cd6fee3857667955145451e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "79c7ae863b6b78ba883a144e5e16b1c8e06d776226e2fc07fbee5e922558c3de"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "89d680a0c158d81d63f56e6afc48aa5374b4b0959193dd88f009afa6adb42b48"
    sha256 cellar: :any,                 arm64_linux:       "744e4c9e5aa054f41b742d27bc010c4e2a86c945f9cfe8f441f5bc193074d5db"
    sha256 cellar: :any,                 x86_64_linux:      "0b9859b858802fc4d5624cee75b1cb6b0b6c304ff88e79b86299dccc457ee841"
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
