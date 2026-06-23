# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT71 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/c8bf06235fe7fd4fa747bce70f7824a03823a6fc.tar.gz"
  version "7.1.33"
  sha256 "edea2c9b62a4cfeecb8fe0e377a2c64553463b195db251385b000f32645e343b"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.1-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 23
    sha256 cellar: :any, arm64_tahoe:   "e2e2724091b46f02e56d3eaea5a86103764a72568c8362c5624c9334c2502bff"
    sha256 cellar: :any, arm64_sequoia: "19d3d7edc2614adc9ef3d96c5c082c79983ac4a4e5e6b4bb90eb633debffadb9"
    sha256 cellar: :any, arm64_sonoma:  "35a2ebbc0324df10dbde661fc21d6f962553a573b3f8e3f71e458208cc91c0a1"
    sha256 cellar: :any, sonoma:        "b83f66c7e0ca80bdf0dc8ab618a4cc7a8b1a9eac28c246d155c80df350f8141f"
    sha256 cellar: :any, arm64_linux:   "181187ab0c464ef6479561a9e4ed527dfeb80d932c1e00dbb40df86afbe48fb4"
    sha256 cellar: :any, x86_64_linux:  "931eab535f94c5cbf3cac00924ff4f0e0372e3e8f3a66d2cb3b63e354289b4c9"
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
        cp "#{Utils::Path.formula_opt_prefix("automake")}/share/automake-#{Formula["automake"].version.major_minor}/#{fn}",
fn
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
           "--prefix=#{prefix}",
           phpconfig,
           "--with-mcrypt=#{prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
