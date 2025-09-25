# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT85 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.8.tgz"
  sha256 "59beab4ef851770c495ba7a0726ab40e098135469a11d9c8e665b089c96efc2f"
  revision 1
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "56198be4267258ccf5fa1cb185fe6aa07b505938588931e7d18f10218c8afb3a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5d25f06ac1e9899db78e32e27d524ff7b2e2d43059fcc3f3319b2b19b6669d7f"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3aae6a575f31aca15e8b3d5c300e08c388cb016218be78092d46beb068d6e136"
    sha256 cellar: :any_skip_relocation, sonoma:        "9e070f6cb5c26b2f6776323fa9970357b8ff5f37613a15300cd106eba55954d8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4b185ac45b6ba1a0379eee3f1510c19e6ca522d8e2e9da35dbd0596037bea582"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8e00292768dbda5d70005e29e00e9bdb9be855a17e003e2aa27cffcfddd18ac2"
  end

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    %w[
      php_mailparse_mime.h
      php_mailparse_rfc822.c
      php_mailparse_rfc822.re
    ].each do |file|
      inreplace file, "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
