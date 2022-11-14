# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT81 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/pecl-encryption-mcrypt"
  url "https://pecl.php.net/get/mcrypt-1.0.5.tgz"
  sha256 "c9f51e211640a15d2a983f5d80e26660656351651d6f682d657bdf1cfa07d8a3"
  head "https://github.com/php/pecl-encryption-mcrypt.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "fc2d2e7b27ace6273cea3380077e064e27590a054fae6d7fd0ff4f40c745afe2"
    sha256 cellar: :any,                 arm64_big_sur:  "39ce9f85c5c0d047e89c9738d7fd5552371c676385f0ee3d94316e4b7d5175a5"
    sha256 cellar: :any,                 monterey:       "047ac8c1119d71a43ec6db43305f5339f42837cab3455aef7a32b986bc3d09e2"
    sha256 cellar: :any,                 big_sur:        "1c69138ea21a2e75209d5ebba9f7d64409539e6d76b568f2a844152a3c6ec71d"
    sha256 cellar: :any,                 catalina:       "e24a0a7784f1ffb57ad448ac808e25490302e1c72f43cff9eba0077962450ef2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3f17fe053ba12067d6e0e53d90bb47f6c875b8e922dc377d7c26162294265c19"
  end

  depends_on "automake" => :build
  depends_on "libtool"

  resource "libmcrypt" do
    url "https://pecl.php.net/get/mcrypt-1.0.5.tgz"
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
