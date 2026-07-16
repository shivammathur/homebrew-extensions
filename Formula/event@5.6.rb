# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT56 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "268a1ca947ec3e4b2a4776fc916198a06c229247eabd4fcae818b31fd14fcb15"
    sha256 cellar: :any, arm64_sequoia: "80099ddf84eaddcc67ca0dd2297fab69440d2eab4f6895c83403a942b5cb57a4"
    sha256 cellar: :any, arm64_sonoma:  "f7bf0019616f5a7710ec3cf52dae054cda890c0ee0ee482d903144e990583374"
    sha256 cellar: :any, sonoma:        "c51ffcc368b6d78a604497a82f478fa6907825f218573eb8b7df1465b1b3f24d"
    sha256 cellar: :any, arm64_linux:   "92ad3d5e9d5a141c745f96474fe00473344b27b384c2270b062448b00a3a9db5"
    sha256 cellar: :any, x86_64_linux:  "7bdf7666f348a875b067198e2b1050a75c3a611c304f3e444cfb2bd987b67e76"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
      --with-event-libevent-dir=#{Utils::Path.formula_opt_prefix("libevent")}
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
