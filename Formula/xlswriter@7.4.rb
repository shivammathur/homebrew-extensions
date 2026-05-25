# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bbe9fe1a27527961597cd48c289d27be069ead3b684658f860a13cc4013b1282"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ebc840c25082757c28da9d25aa5280d77239aeb24e8801b5fd0c3768231a2db6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e3d1176a2f1718095b0cb0cb5650485683286fbdb5a13df6c1e56ad2033a336"
    sha256 cellar: :any_skip_relocation, sonoma:        "ca199bcdfe62787fb175f7af91c1730aa59827a96e4a1a907eebf019284e75e1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "754625bd2900279c3ac108f64465b6add3eb31ee99959b6980a61aae78258d99"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "271aa332780bc26df7c222e9c226ba6785450f663f728a880b226ea4e32e865f"
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
