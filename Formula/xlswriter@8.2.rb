# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT82 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f8aeacc3ad1b7f8659e8bdd1ef148b289ac137f4173214a8fea22288708592e5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6207ce381f7ed8465bfc2d17e102f9a43cc2b288199da5fb531473c06735ef02"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2a552a25d1d94c2f22388cfb2fecc39b81f24d6e430590cce936ceaeeaa52872"
    sha256 cellar: :any_skip_relocation, sonoma:        "a70f338c21c8349346ccd7ebf1cf67d5b9030a1544d0cf29ca5f5554dc314bd7"
    sha256 cellar: :any,                 arm64_linux:   "7d486796240fa8c3d80ea3fbc2b7c52f4135f282efc24d6d53df4d57278fc3cd"
    sha256 cellar: :any,                 x86_64_linux:  "80398b6689698693ec721a078e83b33f12791503ffb76e2ea3eff8a72984ff78"
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
