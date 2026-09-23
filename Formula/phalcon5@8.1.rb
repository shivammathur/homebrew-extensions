# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "910a999afb7eda89c19fa82cf92573a9fe75fced0315d82c0decef7b56474c93"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "393b4891afcbf40b4138ac39fa9dd49202246251e527602a56a31a101eeb60ad"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "427e4ebbb022369786599fe828057e35e9b46a17abaf5ccf99146bc057e4ee86"
    sha256 cellar: :any,                 arm64_linux:       "026f74c71cbbcfb0caafb5e1365b0a32b64c1812263fa8948bba899baa26268d"
    sha256 cellar: :any,                 x86_64_linux:      "a74318e213beeaf503ef57e4f186e29a78eb58c95129709c793b470c01e11519"
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
