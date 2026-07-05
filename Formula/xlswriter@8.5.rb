# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c19f4352ce742f4de40cfe1f246bc6c334e974302ae1e06c9640a0af4af3720a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2c79586f861a4cd4f96be647ffdc032e9fd469600242c6d24796f10ea3367e07"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fbfddec756983f31236af6e578f4fefd560b5497faebe0bdbb7bdfba3a98cd48"
    sha256 cellar: :any_skip_relocation, sonoma:        "0903a9d5568e8863aa6d47b897a698fa1bfbb07dfa00f22ed2aa8820feff2113"
    sha256 cellar: :any,                 arm64_linux:   "60877de8614423548c7e977a6ed30863d9ca29a697be5f1f1396d08076823fe9"
    sha256 cellar: :any,                 x86_64_linux:  "096aa392cf49d214f84d21339650f35a961cf362ab2ca826d62a20da1dbbc903"
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
