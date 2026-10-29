# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT56 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "ca4ad103ad9a01fc4ad8aeece019bcc486a47d72e422bdb6d733cab3f802e235"
    sha256 cellar: :any, arm64_tahoe:       "58f76996b1c8386adcef5190bab66563a0b298d55630e080c0e6ae718809a30c"
    sha256 cellar: :any, arm64_sequoia:     "566b364f3fbde5fda984f604dde34644e95e8295698a1a9bf3422b095ffe1973"
    sha256 cellar: :any, arm64_linux:       "f71d96180c68197d2293f2c97d5aefbc6b8bbbb8bf9c6bd9914f000681638c25"
    sha256 cellar: :any, x86_64_linux:      "4110d1c45b851d80d8d7a5d43e4b18d09701967672a422e210d8f85fd760b81f"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b896540a30a5d170797a1171b04dd872b88c5b.tar.gz"
  version "5.6.40"
  sha256 "8fabdeb0a133ab8ea9cb5e590030d824e7ae9ca7703c19a958c9628938d185d6"
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
