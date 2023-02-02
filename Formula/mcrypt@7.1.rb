# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/3ec3a5352eb55a241b2e22e54e711b24f1542df0.tar.gz"
  version "7.1.33"
  sha256 "68e64a7a50b5649f3236bb39db32aef85a1082345ad266fd0af107d69b53b0ed"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "79b972c3a2eed03f77050b987a1e265bdb61319aae079016d8b00cb14e45d350"
    sha256 cellar: :any,                 arm64_big_sur:  "1f39de9bac34b9a1e062605a4334d788a12c6e336d97da3d918b9617ae058ade"
    sha256 cellar: :any,                 monterey:       "ff9e2bf92df54b16bf6a7095cd783162b8e019230b295d52adf005d3cffef3be"
    sha256 cellar: :any,                 big_sur:        "473b2bd7261505a3d2ac31ac23be2c0fd261146523397ef9f32f356c066ec745"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5814a5e92400fea0b93f98bfc7ca96b21256e4fc36abc45d0fb8bb076700e3dd"
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
