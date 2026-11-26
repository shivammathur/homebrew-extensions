# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mcrypt Extension
class McryptAT70 < AbstractPhpExtension
  init
  desc "Mcrypt PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/421d8fd17a77fbb7c6c9dd4effeccd904025872d.tar.gz"
  version "7.0.33"
  sha256 "7d75d172343920cbd1ae1a8f02556b290180db94eb0fc308c09a2c926ef601bf"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    manifest_sha256 "14ae0a2df18e06e153d71fe80fee48fc8fc5ebbe80f4439369a1e2a89cd2b725"
    sha256 cellar: :any, arm64_golden_gate: "32532b43c6b4d6453771e572c36c0e076559fe7788f7799ff1bdf5911f226305"
    sha256 cellar: :any, arm64_tahoe:       "39790869d409b512bd98a1f87dfe7706a9b0acb5c318fae74c067006f47d5a3d"
    sha256 cellar: :any, arm64_sequoia:     "acde1a775872f15af83e10eb7f180d3907d936aebf0e5c3baa59561f131375eb"
    sha256 cellar: :any, arm64_linux:       "d3410aca3d86e03f2cbf154093ab36e1b5908f182061a139a9bf2dd3784f74d1"
    sha256 cellar: :any, x86_64_linux:      "35a2bf00542994c7392b26222313d35a9f975e503b016e18a5e598a8c899d510"
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
      automake_version = Formula["automake"].version.major_minor
      %w[config.guess config.sub].each do |fn|
        cp "#{Utils::Path.formula_opt_prefix("automake")}/share/automake-#{automake_version}/#{fn}", fn
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
