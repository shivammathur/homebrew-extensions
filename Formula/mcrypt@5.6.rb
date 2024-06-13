# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT56 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/30e5da4b4bf8604149f19d4f73ff2220da3205aa.tar.gz"
  version "5.6.40"
  sha256 "63619b43de54f884a87f638a41f827c1b978ee3deaa24e0266922f6ce49a78f6"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sonoma:   "d709d460e6e6dae53979fc263696fe68ec5e5106d2f2be161532a43237071808"
    sha256 cellar: :any,                 arm64_ventura:  "e34fd855dac6f899096c81fc3e2476e8da05dd4df07800b7d90fbb10e09d1044"
    sha256 cellar: :any,                 arm64_monterey: "b6461eb435182b34f43f729a3cfda77db2efc2da82e9b925488760bdd24e32a9"
    sha256 cellar: :any,                 ventura:        "7a8b5dd0fc2a48505537ac644fe0cb834dbf050ac7dc3daf947f467321a7a771"
    sha256 cellar: :any,                 monterey:       "f28a3481b1df8eb405359ecff3176ff38f9c81751985850e890d1ff735c3e239"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e06e8c50a0f37d8fb6d9107f758c00ba2c0061afd09b744b28b4ad73cfd5bc49"
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
