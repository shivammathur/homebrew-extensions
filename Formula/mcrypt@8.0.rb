# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT80 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.9.tgz"
  sha256 "2a9ef0817d3bf677f6d7baf8e325629a2758974735d8abad6566384788d424a5"
  head "https://github.com/php/pecl-encryption-mcrypt.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "c2775e12f4bc8c26be21eb3109f4ad8c86c13efb50ed9d4a13d2b7f0bdb2c312"
    sha256 cellar: :any,                 arm64_sonoma:  "324593a136b026b18f8819e86444a3c2247cef51acfddf311b48eeba8a31da58"
    sha256 cellar: :any,                 arm64_ventura: "6d4655875fe8b2f49fcdd805539a1a575a35a23acf5b3e85b6bb379e425d5547"
    sha256 cellar: :any,                 sonoma:        "884292179ec2c09bb4d17e0d7412fcf3a8668ff030c57a50800d61e283762b09"
    sha256 cellar: :any,                 ventura:       "281e1702a1e749a3ce5562f2e3633eccd207e310b2529da5ea076c4e87fca17f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e8cbc6717eb96497b4e4342f3e8b5bf87bbb4591217b535137db2afa2bf0b1d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6fd341049ace69ddafe47ae08506c2a871ede59b931bfa261421207d426d793b"
  end

  depends_on "automake" => :build
  depends_on "libtool"

  resource "libmcrypt" do
    url "https://downloads.sourceforge.net/project/mcrypt/Libmcrypt/2.5.8/libmcrypt-2.5.8.tar.gz"
    sha256 "e4eb6c074bbab168ac47b947c195ff8cef9d51a211cdd18ca9c9ef34d27a373e"
  end

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    ENV.append "CFLAGS", "-Wno-implicit-int"

    resource("libmcrypt").stage do
      # Workaround for ancient config files not recognising aarch64 macos.
      %w[config.guess config.sub].each do |fn|
        cp "#{Formula["automake"].opt_prefix}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}", fn
      end

      # Avoid flat_namespace usage on macOS
      inreplace "./configure", "${wl}-flat_namespace ${wl}-undefined ${wl}suppress", "" if OS.mac?

      system "./configure", "--prefix=#{prefix}",
                            "--mandir=#{man}"
      system "make", "install"
    end

    Dir.chdir "mcrypt-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
