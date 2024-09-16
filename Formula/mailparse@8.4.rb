# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.6.tgz"
  sha256 "a69f1605583eabdb59c2cd4c17334b3267398a1d47e1fd7edb92d8bef9dee008"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "477564afc3df13ae6ee25d0f2232d05284ae7b5567995f2ccad70cc2479abaaf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "703157845db5e7474308e42befaa389b9c44de0b0695166ab85378eb94fa60d7"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1aa7a2a493f35b1dadae1f5348ceced205edd2b63c85af85e5653d3f77886e45"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0965bbc5ce6d4384fdb4f3cd0e9a92c99bace0d7e9ead0be545252e95dc2b3af"
    sha256 cellar: :any_skip_relocation, ventura:        "cc2715ee252a6d07d4b98b3e4d75d5db85e0bc30e6a7ae3b9db0b3e55e09919d"
    sha256 cellar: :any_skip_relocation, monterey:       "097f53cda20ae1f78ad0bb4879dec8f6dc0886cf798575207027652473bf7d83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "733889cfb9d91b35b1da5986e5d5fff617773a7cb89a10a3dc9cb57b80358508"
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
