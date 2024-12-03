# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0b4739231d1aafc053c871c831bcaffa0ec8ff141086bf9c20c77648a7e8cb73"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "19c9e7b76b7aa0b38f69f76a4dc9048c9c89991941416c8d7301154c1ec8e97a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5bdd383bac94430de4072b20e2332f08a958315e667d9714edde68056accb367"
    sha256 cellar: :any_skip_relocation, ventura:       "ce9a685e703e8f43071eaad170ea07fca7e77433ff2a063df19796787aa89de5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8a7f76f5a4e01ddf0ba3fc0f08f62f3bf2c831293a608f5a248818807da203a2"
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
