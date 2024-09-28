# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT85 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ca75bc7ba5b28d416f73a491cf1cdff49dc1bb824e8b5fa0a55d8c553299dcb3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "998036a3c74b8c9dfa69f346cf1dc0943564fdbf403ad66949d541f2ee696e06"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "61fc5a68f4912e9f9b6acaa2ac225dc2891060609fab9b03a456461cd30a407f"
    sha256 cellar: :any_skip_relocation, ventura:       "a1f9bd93b974f2765f27b167dff54ff83e6a8a99fbb1ca3bcbf06771066eeeab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9f06c0084a0093aa885252456db8439df920b6b2f2da590d69d263e0e57f8b0"
  end

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
