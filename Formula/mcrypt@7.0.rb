# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/0788496bca56ea3a6ad75758aeaa38f81267415a.tar.gz"
  version "7.0.33"
  sha256 "6b59873eef34f7205e20683a0e6ad99509a1c158e619ff52ae6269d64d49f5e9"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_sequoia:  "60007593ed59e6e622ef2939076e017132cc69fe7094b1fd6babb1c4e78b78f7"
    sha256 cellar: :any,                 arm64_sonoma:   "c274d9d290f1988c548ab1d2e2d666690507d0923e9bc799d1b17349d299547d"
    sha256 cellar: :any,                 arm64_ventura:  "ed3e645954edd64ae715aadcc598d5baefd58a4b66b4423257031303901be905"
    sha256 cellar: :any,                 arm64_monterey: "0c215574ceb79de06c25eb204db81c5861c8758da56707842be5036f5caa334c"
    sha256 cellar: :any,                 ventura:        "d8233d6381a676fb25a64f864339ca1016336b6ea5eff076d5fbff058004e0a6"
    sha256 cellar: :any,                 monterey:       "33b11a1478859b5985ecae985ad83231d68538736ea71bdd761a5809394520dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ab4c87b2f5ddf6201fadb1de4c4c5e9d2c01656e353f6df1f5758fbe61f12332"
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
