# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "dc7881146d0413cda26ccde3cfd92fdfe064ff6783baf72d7fcfca2f8ffae2bc"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "ca93236a0a2240407d51af93f65e22809c4b7b2a1431434a2eac0c16cbd6e98b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "629f05d85ab548a68b2081c49b750ad99c59ea16a720c93630be801173ce3c2f"
    sha256 cellar: :any,                 arm64_linux:       "34d06459fc04a4346a3299aa817130c557984f5543b33173dbb929834bfdf1df"
    sha256 cellar: :any,                 x86_64_linux:      "7c86cd8332451aa5d8845cecbbf881de58fa4a9969dd28a5b13b55dea7ba6fe9"
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
