# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT81 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "519d3188238804caf20ff789e21cad78d70c5ac31038b3cc40a80dc4afb53408"
    sha256 cellar: :any, arm64_sequoia: "dd40cad38bdc86735dcf80c97553dce370f486b4fc36f093b66636dcce6a4155"
    sha256 cellar: :any, arm64_sonoma:  "546ec8b133396a17d1adfdc9f4324a6deca44690d6e2fabbe639fd55c8a5befa"
    sha256 cellar: :any, sonoma:        "a727ec10d3c833b52d7740b23a17b59faaa96c984e6d93e500d29bec841184f2"
    sha256 cellar: :any, arm64_linux:   "acf70f80d5deab3b60003c303370e72b1f6b2b2fa44e43a3f077f888145791c9"
    sha256 cellar: :any, x86_64_linux:  "877f93fb2d0d22d4de37d77f10c138e622d2420edc66ad0ee2a6fb44a13ac0de"
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
