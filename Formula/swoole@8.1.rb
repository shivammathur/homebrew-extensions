# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Swoole Extension
class SwooleAT81 < AbstractPhpExtension
  init
  desc "Swoole PHP extension"
  homepage "https://github.com/swoole/swoole-src"
  url "https://github.com/swoole/swoole-src/archive/v4.8.10.tar.gz"
  sha256 "0bf908cee05b0aafec9fbbd3bf4077f1eeac334756f866c77058eb1bfca66fd7"
  head "https://github.com/swoole/swoole-src.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "95e13c8cb39448394afa47f3bfcb04621bec27c4e1032cd0955362eb8a3b749b"
    sha256 cellar: :any,                 arm64_big_sur:  "801f7f156cf82ff5a6a4ca3524b831f2cbf6ffcec6d49bb7a2329c7cb8100a4d"
    sha256 cellar: :any,                 monterey:       "d812eccf758f47cba04fe56345382cf362d7ae5cba16a3a27ab9ab88f9a036d4"
    sha256 cellar: :any,                 big_sur:        "d7184bb46af49d69f90b3cb93dec4ed83768784f3585f1d94c41c4887d651a9e"
    sha256 cellar: :any,                 catalina:       "cf67301e3234c78bd256a1922125902fe2f9ed9c063e1bc05ab710df3bb43a7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8abe33b1130c0bcbe48e58b4eb1b570037b1ace6c29cc41049ba5b244a1433f7"
  end

  depends_on "brotli"

  uses_from_macos "zlib"

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
