# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT56 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    manifest_sha256 "ef0527ba3df303b811496c19f93db314a7e4e1aa9a0d7739e2833291c06c8ba2"
    sha256 cellar: :any, arm64_golden_gate: "c1e20ab944af54ac7193d0be8d3622b8ff2a3062e18c4e562375e7a1142b4dd1"
    sha256 cellar: :any, arm64_tahoe:       "1531358d35e787c01bb3dea7296c039900d379bf9c90a53d3824ff1d4bf338c7"
    sha256 cellar: :any, arm64_sequoia:     "6db919ba6eb78937270e15d23a30ae146b0a20134375b5b79de9c42735ced238"
    sha256 cellar: :any, arm64_linux:       "b3876bcddc6c16ca6f85de55851dd34e2a09a39c8e42a2ac09621fc39e8fe4f2"
    sha256 cellar: :any, x86_64_linux:      "5c368f12dbf0677421e1b36279da0120c1f3981cf5a6c5673b4fc7ccb2a45cc9"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/25fce28ca29c7bea677695e50c5ed52139122d20.tar.gz"
  version "5.6.40"
  sha256 "779061ac26e633a1fd52317531a8473bf89872408540ee708d8e3fa285a89538"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-int-conversion"
      ENV.append "CFLAGS", "-Wno-incompatible-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
