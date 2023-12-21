# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT72 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.7.tgz"
  sha256 "12ea2fbbf2e2efbe790a12121f77bf096c8b84cef81d0216bec00d56e5badef4"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "636ee3884288c787228b5be2be2763fdfa54036cf205910665fb00f2a5d34e2d"
    sha256 cellar: :any,                 arm64_monterey: "c60a82d1387c8da1beefa8f96e48e51b8588818e7d26840a7c099b367f35968d"
    sha256 cellar: :any,                 arm64_big_sur:  "6717b7ba6f1d3ce1ace08003ed040fd3b0d759787adb23c2011b36aeb1130d46"
    sha256 cellar: :any,                 ventura:        "ac0277ca04dc391872f8372744c7cac5441919d5d7c1343a72e42385051a6328"
    sha256 cellar: :any,                 monterey:       "291f9799930184f9185068d0ec4a62ac49d2f13681271b3de94f3059ae9b42cb"
    sha256 cellar: :any,                 big_sur:        "da41dde11e976edaaf6e5582fd8b3373a33592c432058504b9034c760d7c36f9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "63f974073f491834e3a4445bb1f54e6d342761c309e2025b08938c3046f2db1c"
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
