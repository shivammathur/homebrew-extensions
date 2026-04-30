# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT86 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-1.5.8.tgz"
  sha256 "202ab46a0fd6d66d21cf5e58bda67e58f05ff95109fd955ed67941466d1c833e"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8ac64802a24d1722f74812a15417df962383a415ec37df59f977edec289eef8b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "09bb35059a267f3e7b9a5c2f38905fc1442a6bd3a0d8ce64c8b536c1c9e4b0c6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "90f34a8b29d3a06ac2692a049c695fad5c536218a4194a816c18396a0ace96dc"
    sha256 cellar: :any_skip_relocation, sonoma:        "ad96000ae3a6f72f7e7b70ad6c2dd9de8300a5044cd4201182775c728443a827"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a62ad6d73cce7e8b2ff32d18425b01ef0c4e83b8c5669a42fe17ef3ed5050c0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a99ed7e1a746e69676e182d451133690366919f7c875270b8263d73b61d7ad3d"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    ENV.append "CFLAGS", "-std=gnu17"
    Dir.chdir "xlswriter-#{version}"
    %w[include kernel].each do |dir|
      Dir["#{dir}/**/*.{c,h}"].each do |f|
        contents = File.read(f)
        next if contents.exclude?("XtOffsetOf") && contents.exclude?("zval_dtor")

        needs_stddef = contents.include?("XtOffsetOf")

        inreplace f do |s|
          s.gsub! "XtOffsetOf", "offsetof" if needs_stddef
          s.gsub! "zval_dtor", "zval_ptr_dtor_nogc" if contents.include?("zval_dtor")
          s.sub!(/\A/, "#include <stddef.h>\n") if needs_stddef
        end
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
