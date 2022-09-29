# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url ""
  version "5.6.40"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "7f22faa5a7e02927477da595dcabfbc8c01e557707e885a4e82824b408b54c0b"
    sha256 cellar: :any,                 arm64_big_sur:  "5367195bd897c8dbbaba159b9d357f6fe93779f9bf49ea513da3fafc32384ae2"
    sha256 cellar: :any,                 monterey:       "17735331fe20ccfec6614ae6128f3dbcb1ab301ad980e4de4b0b9aa759fadf3b"
    sha256 cellar: :any,                 big_sur:        "304250e229634d7be28f1debc68a2c170ddf0b573ecabe1b0869bd00a92c7a5a"
    sha256 cellar: :any,                 catalina:       "55436db8ae5c1c9d98153db3f923d9112bcdec98bb440c4c3824b0b10521cf2c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "50956fcbc4653f351d6a8d43fb4da3b3a77652feaba83a63f80e7145d9dfee65"
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

    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
