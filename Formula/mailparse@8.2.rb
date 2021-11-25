# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT82 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.2.tgz"
  sha256 "b0647ab07ea480fcc13533368e38fdb4f4bb45d30dce65fc90652a670a4f4010"
  head "https://github.com/php/pecl-mail-mailparse.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "07509bb7c67a08ff4486c8c48d85618228e83212e68321a36c614a7c2998dcde"
    sha256 cellar: :any_skip_relocation, big_sur:       "db69242c6258f70380a21067d07d77b26bd828801185d468c667793524ea3861"
    sha256 cellar: :any_skip_relocation, catalina:      "f08f7e6745ec8d11eb039b64e191842ac71845c7e6991e08cd36b5d4dd92d2aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f0f1bdd5e298875153aecb25911f860062616b9fd35f859436b3433dbd106f74"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
