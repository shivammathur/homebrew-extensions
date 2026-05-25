# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT71 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a823c86158b58b3c619b1b6d773fd3895a7f1faa4431d33e0c1b819cba2857b0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e87ea1db6ab6b59ab159aafccb2b5e422cffbfe1019f203620dc52dd0bb63a67"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7b92a9631307b320dfc4c9ffff9aa635f529a92c25a4fb079041a042507c8a1e"
    sha256 cellar: :any_skip_relocation, sonoma:        "605fcad582b70688edb274cec59c1a426a0a9948699eb21b228cc4200f685cbe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d659f35df50cde8df2df155b7378e2d79e7229a4b49a726b5fde019a1abc4aa3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fa2db5373c2652b265eac1d9a32be9296ba5974f15825f784d3edd6173e3ac77"
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
