# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT86 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  revision 1
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d36628ab0ada6152dc2ce2a7403a3f7d5b84947a1a4ef5e8c9e0abefa7b0cee5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "309b834504df19edb9cda4107497317b023d590059afd1682e381ad0dd08fcef"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "16f8ec7ac21aa65b6ac7471834a1d30bbec959cf72ef94b647cb1263654fd605"
    sha256 cellar: :any_skip_relocation, sonoma:        "51d7846070e9c23ec3d72d34fb8bdace0639468e8d2753b80f70e203bf1aec32"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5d9bacfe81ef83aa21a61d1d37e04c953d08d1fb93e7734b15bf60594c7319a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "09814244988791ef842fea16cccd1de10947443a49c2a05edba3c3b2eaaa5ffe"
  end

  def install
    Dir.chdir "apcu-#{version}"
    inreplace "apc_persist.c", "EMPTY_SWITCH_DEFAULT_CASE()", "default: ZEND_UNREACHABLE();"
    if File.read("apc_cache.c").include?("zval_dtor")
      inreplace("apc_cache.c") { |s| s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" }
    end
    %w[apc_cache.h apc_iterator.c apc_iterator.h].each do |f|
      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof"
        s.sub!(/\A/, "#include <stddef.h>\n")
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
