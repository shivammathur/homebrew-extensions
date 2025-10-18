# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dc8d6277d12d445642139b8a7c104898a5a80f80.tar.gz"
  version "7.1.33"
  sha256 "3e7a3342f58ca8698635631993a91541d88e7ddf3335e15194d23dafd5bae409"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_sequoia: "5bd6a6924d865a5435d04d5dd3a277cc67a0df3d7912482f1ed264656c6a92f0"
    sha256 cellar: :any,                 arm64_sonoma:  "11b5bc026955aeda0bf30b64346cb5c4a6bab0b757956b2f6a2401961db7644f"
    sha256 cellar: :any,                 arm64_ventura: "43d911662b870186a2a0c489988e1f8abd65fa17a874815898a2824c8df1b8b3"
    sha256 cellar: :any,                 ventura:       "36ecd2a4989ef13aa6982464ccfb79662d0fe3735cd82450ef61c446ac22d074"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "732617cb4fb0b06d9ae6a7cadc1e3583bec38bdc5f068b527c7ef33373432b5d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "60bf3bfd7cbb08485f0445155d7e3b23f4386273ea6da5f32bf16a6d2b28b488"
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
