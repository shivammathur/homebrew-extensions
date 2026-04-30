# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT86 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  revision 1
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "ecdc5a5f3d9b8c4e080d7c3dec22cf54c17c58c3873fa46cc3963eed9aa2e374"
    sha256 cellar: :any,                 arm64_sequoia: "77299eacc8e004876556932298dbe5213f1734a562a852415d55694224da5a76"
    sha256 cellar: :any,                 arm64_sonoma:  "5073642b241670a21cb0ada3625adc5a19c29a5e39247e9424352249965ef684"
    sha256 cellar: :any,                 sonoma:        "7dc30ce5631a690b9be31b0f72bd7fde5fb654c073bee1bb29bb88b523a31082"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b1c989677e005264c935c95c5bf0feee2724c41c3c0059d0588ee390efd6c285"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9196ed686a942c61cb3aa4f60bd445b7518cb0aeb4e62880ee4b5009caa7b822"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    if File.read("php_gearman.c").include?("zend_exception_get_default()")
      inreplace("php_gearman.c") { |s| s.gsub! "zend_exception_get_default()", "zend_ce_exception" }
    end
    Dir["**/*.{c,h}"].each do |f|
      contents = File.read(f)
      next if contents.exclude?("XtOffsetOf") && contents.exclude?("zval_dtor")

      needs_stddef = contents.include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof" if needs_stddef
        s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" if contents.include?("zval_dtor")
        s.sub!(/\A/, "#include <stddef.h>\n") if needs_stddef
      end
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
