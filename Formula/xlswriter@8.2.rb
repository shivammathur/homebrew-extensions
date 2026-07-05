# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8b657f0b12fa8e8fc86602a33ec4eaf9ea6dfcfb74e0bf6dbc8e656663492cdd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1fea70957b7297cd62033b9a2f9ac0a3fd2c3bdbbb90c20b73a311d69c97cae5"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f3e0cc6e776949f5b595ec280c758abd19446e50100918dbbc024e1bc8ee390e"
    sha256 cellar: :any_skip_relocation, sonoma:        "6ec0a53a2c9f5962ae86036dcfae4f6dbb20fddf4fe7614647bbc5ac3b0bc268"
    sha256 cellar: :any,                 arm64_linux:   "3f5fa4fdb21d9b9f8dbc14ff14c25823b9e686099d5e4534f93152df951f617e"
    sha256 cellar: :any,                 x86_64_linux:  "496b6c0d35536044079bb2199ca812830f0c3b4093eb15d2339402cd791c4854"
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
