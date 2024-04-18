# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/bb2ce3eec92a574a46b709ea36604b2564b8c94d.tar.gz"
  version "5.6.40"
  sha256 "85e5ebda9e374c7f2970fb79804858ae30c92913c93520848b8cd2e7571aeb7e"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 13
    sha256 cellar: :any,                 arm64_sonoma:   "73a5b27ebe4e0a27ddac48ef4dd6cb6455d99a0737e32693ce0c7a9a8509c33d"
    sha256 cellar: :any,                 arm64_ventura:  "1b39f2c08778cfd44b06c77543a8d1c7643880331f6ef6bc3533c38bdc07face"
    sha256 cellar: :any,                 arm64_monterey: "3327156c314ae14fee9738ac97d76fd8a70c78423f93303ac7afd860d6b302db"
    sha256 cellar: :any,                 ventura:        "d61afabfdcff9f412e9f017722edb4afca1099983e6b3c4f98eec518546aee4f"
    sha256 cellar: :any,                 monterey:       "c1967b048d67be224ab373f4b4ec9f71b7934eae25118be064dabbb226a4aa93"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1105e15aa5bef5128ea90a90a3cd3d8427905b8abacd93bdb25e35f4e1c7a6e7"
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
