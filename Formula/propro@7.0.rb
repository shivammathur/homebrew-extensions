# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT70 < AbstractPhpExtension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-2.1.0.tgz"
  sha256 "7bba0653d90cd8f61816e13ac6c0f7102b4a16dc4c4e966095a121eeb4ae8271"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "d47a82a8fb7287033cbfb24d1775449a4ee85f1585f1477ee3a7a4d79cacce79"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "fe81b4a63a558873db69cc900c7398b94c2fb7461ca6b271037c2576ce765cf5"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "aa9e3737f25c2f7f7fa85eafe20e5f24ee9fc3b61d88db609c153e7867eb479c"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bccbaa9b3fa407d60429025d3957ba63dc2b3d9a1038dacd76fe2b680cbc3754"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6e20aa5721d8d97b992c866845f2096eb11c89ba1defc3d589240f7707d52fd4"
    sha256 cellar: :any_skip_relocation, ventura:        "867f5d81d1244fdd81b0e009bf0b24697ca80abf4eef309cc579f21c2760b8f9"
    sha256 cellar: :any_skip_relocation, monterey:       "97efe61fba56c705dea36908cd06ad25e519b5215207566544b7b39c3306f318"
    sha256 cellar: :any_skip_relocation, big_sur:        "2fc7721b01075968e6d39443b9d755d83e91aeffec338d6769fa92bf336bf646"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c530f72f4fc589c8500929126f62fbb1708d73b5cb69451812022b241b802949"
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
