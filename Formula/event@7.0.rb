# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT70 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.4.tgz"
  sha256 "5c4caa73bc2dceee31092ff9192139df28e9a80f1147ade0dfe869db2e4ddfd3"
  head "https://bitbucket.org/osmanov/pecl-event.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "8952ec2aad35d9047515d6b8012f0a62f2f8fe1c560b5b6b66fbccf3adf45d49"
    sha256 cellar: :any,                 arm64_sonoma:   "5348f8cc7a47cc2679a5075e6b0a8b1524becbc6c40db5efb19b401f1fd58641"
    sha256 cellar: :any,                 arm64_ventura:  "17424e1dd8b9150283682afc5610bb69de2fafade0a25586e6cfaae31b24b56e"
    sha256 cellar: :any,                 arm64_monterey: "0c1a457bcfdcbbdba8056b98ac2f2e502385862caa6cd20455e7b1fbe658aede"
    sha256 cellar: :any,                 ventura:        "07a2fdd423003d91766e9961f874d7caa50c3c8966dbada11a9d20b29a4029cf"
    sha256 cellar: :any,                 monterey:       "e09bbb104d1f52cb55d4fe52bfe5ad0684984df69a1a2ddd5bde00c62d8a3cdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a3824596a188e4bfe5e7995373975c48d2018f6db8dbb2ed8de739f9117e105"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
