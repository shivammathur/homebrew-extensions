# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/f77964ef49a459f67561517cd77292ec505a03f7.tar.gz"
  version "7.1.33"
  sha256 "f4e0826d2fe16ae4dc9d6b7b54a0c24488fb1b66c8202f8a0c27987a9172ec61"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any,                 arm64_sonoma:   "a1889b443755014d9fd55242a19a9986ac84e927fa9b02dcd6aae59439af8019"
    sha256 cellar: :any,                 arm64_ventura:  "307bfb47b216da681511d5cccd0dfca246fbd4cc7f6eb0e1ae22708c0795f290"
    sha256 cellar: :any,                 arm64_monterey: "71d9974a45fb67976b2802855ed63c1a11676042fb63e1961c6258a7e433bf87"
    sha256 cellar: :any,                 ventura:        "03a8aa29ecf7cc8f3e35f674796dc3620f4eb50eb0bdb3e4e7e201b428804ba3"
    sha256 cellar: :any,                 monterey:       "68caa1a9973e1778925d2ef9cff14549ad5c53dced6e64f8ad637ca842eea9f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "169d7dd41ea1bf00216c164be1fe8ee8ec234c0190dbea44439cab0acb5d87e1"
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
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
