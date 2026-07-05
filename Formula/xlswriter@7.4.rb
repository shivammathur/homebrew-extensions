# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-3.0.0.tgz"
  sha256 "a17986ad5ac09529513fc59b2871ca2b53eaec1c2c55cf00be60a292e85ade73"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "74f588fe2647535cfafef48d94c376d8316ebf08a19509510a293136db30ea2b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "14d97ed9ba8956b3dbbf751b9cf4689517a35fbb6b1dbc2c16dcdcb793f8ec00"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d3a5a4c67abf22be0c4167288dc7b6b0ba583572479754265101d5df55c443e7"
    sha256 cellar: :any_skip_relocation, sonoma:        "6774dbfb719c36d38a73f2ea760e28ac48ee87c0be701176e3a5b533dce32220"
    sha256 cellar: :any,                 arm64_linux:   "25cb1cd61c32df04681f56eaa024cc9b5939395e2b5a3440d466b72981a8a4b7"
    sha256 cellar: :any,                 x86_64_linux:  "64953af88e1700e548eed9822c86b395f30ff13ca09df738e439a4d970b744d6"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
