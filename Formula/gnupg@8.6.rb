# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gnupg Extension
class GnupgAT86 < AbstractPhpExtension
  init
  desc "Gnupg PHP extension"
  homepage "https://github.com/php-gnupg/php-gnupg"
  url "https://pecl.php.net/get/gnupg-1.5.4.tgz"
  sha256 "4d4a0980759bf259e4129ef02cb592bbeb103b4005e7b4bb6945d79488951a50"
  head "https://github.com/php-gnupg/php-gnupg.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/gnupg/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "95a6550d9b10bf1f73b607145a4bf9fd65dda9215840cf1e984239f4b2d502b4"
    sha256 cellar: :any,                 arm64_sequoia: "406923fa4a97cd7e5c1b503b329139a60b048cb913a959eb5d5836210fc42e5e"
    sha256 cellar: :any,                 arm64_sonoma:  "c299a5e77522ed65a5b0378ea322c2e662a17eaa120d35264ee5cf47f11cc1a5"
    sha256 cellar: :any,                 sonoma:        "b0b293f2b3ab80f285b615bcade2919eaecae140ed4e3e6ec7446792dc733b27"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "388a11373641756cd50e2fc0bf4e4ee6ff74e14955587fc49e49131791e45084"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7c63b8fc9b6c757e0a5a027fe44c5b714f8729195fb7487643b3d54e3ae734a0"
  end

  depends_on "gpgme"

  def install
    args = %W[
      --with-gnupg=#{Formula["gpgme"].opt_prefix}
    ]
    Dir.chdir "gnupg-#{version}"
    Dir["**/*.{c,h}"].each do |f|
      next unless File.read(f).include?("XtOffsetOf")

      inreplace f do |s|
        s.gsub! "XtOffsetOf", "offsetof"
        s.sub!(/\A/, "#include <stddef.h>\n")
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
