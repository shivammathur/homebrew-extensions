# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.2.tgz"
  sha256 "c85b6739e4e6b0816c4f9b4e6f7328d614d63b4f553641732b918df54fe13409"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "32b288aee8ee58d28e3751b3a44fd99b5e0e4006b5fef165675b223151ce8dd6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d33cf8d0cabd4405c8a6dc5871cc191e4acd128468f2aef0e161ffa183062dee"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c50bc0e412cc3db068adda1c55c889c48b4ccba4492f83531ec41643494c1d8a"
    sha256 cellar: :any_skip_relocation, ventura:       "3f1ec4e9c5619a716c30cbe3b25ae6d06dc63c9a1dd7fd98922fa7c35025021b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f76fb8822d897b759a99909d67795a9e67f489b12de8a6d6baa8f5f21f7eff4"
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
