# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT80 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mcrypt/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "981e6ffab262107dd4b8922c9d37a2d17aefa7d9ce3019202d52dff15d956031"
    sha256 cellar: :any,                 arm64_sonoma:   "a1404679b7c7cecf762a4adeda3e401d24f58d5cda9631a975d52636e18f7b91"
    sha256 cellar: :any,                 arm64_ventura:  "6df9dee38b14184ddc7e25b5790a57062266320d90634d55a612a858f1d94c12"
    sha256 cellar: :any,                 arm64_monterey: "b8812bf6d310640b3b37edd42534f4129449e1e1e79b7ff1f202bb08cdc8e143"
    sha256 cellar: :any,                 ventura:        "286655c91a88086beff1408e84defb879e05cad7b5f7ebc99a6bfb0b8f8c5aa9"
    sha256 cellar: :any,                 monterey:       "26f59b16e3f755c2b4933e07f7298e7362ae41c8d36932b2872731ef22eab433"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "57d0321582876e0359eb295144de7d434904f4a5dec53a207f2f9db4aa8a2de5"
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
