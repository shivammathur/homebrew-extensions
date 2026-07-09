# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT70 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "9b4f73cd108cd02588c3b36bfe528e10cf6abd0275d83eb7e54016f9048e2bc7"
    sha256 cellar: :any, arm64_sequoia: "f23588e72377b064d8892c295c63edfc13b94eac191483775bbcf040555d4d03"
    sha256 cellar: :any, arm64_sonoma:  "50ad84f02e463e628cde8abee0d713771b19333a2d4cc744026ff6eec470f6e7"
    sha256 cellar: :any, sonoma:        "c9dc0e68d4aea8519b9de6cc3ed6d0d57464dbd7672e9be345ad8f1e82a4b01a"
    sha256 cellar: :any, arm64_linux:   "f5eba94ed2e82c66b444db151fddd822914a38d28781fb40bf2fcf3d9b99089f"
    sha256 cellar: :any, x86_64_linux:  "801588d6977cceae135ca1ad5c95a96bc2f44e154a7995862ccd1749510bc547"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/da64b9b864bf43d9023d6d1d6d5b582800d72c9e.tar.gz"
  version "7.0.33"
  sha256 "c412fdeac66cb816f3f3fa5a7a6755daf3f37521d997fca771ecd40f61b22cc3"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
