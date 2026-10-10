# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT73 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.6.tgz"
  sha256 "5b74554c6370aae8c284c8110fe27e071d3f663953c3eb762ffc429b0a3c83a2"
  revision 1
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/event/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "c01ef3f06e59a238d14491bd909f0b0d2b41740d92d00abc6159312ab162a0a2"
    sha256 cellar: :any, arm64_tahoe:       "d17ae2bb503039fe2ae9ecfa4bbeef82ca38e57d334bf68cc0cc9214ec9f7fa3"
    sha256 cellar: :any, arm64_sequoia:     "41fa61f55396dbe694bd0654bb8356dff95defabb0251510a58bb209695bb317"
    sha256 cellar: :any, arm64_linux:       "d94ff0d1aef161009e96f42ac106af45eff991ce9467e322e52066252ab7df79"
    sha256 cellar: :any, x86_64_linux:      "59d3e673be90c4d52f5c50fc0c4cd2a44c64b966ded2e504833a236a3639c8ab"
  end

  depends_on "libevent"
  depends_on "openssl@4"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
