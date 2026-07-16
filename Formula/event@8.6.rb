# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT86 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "3f71e1be92183d86ada4403d8fe50374282c16e8855773e201a40801d3dbf27a"
    sha256 cellar: :any, arm64_sequoia: "829abb237e3fa3055b6a1fc6c83b2a8929c486590923550927e9b466adfad29d"
    sha256 cellar: :any, arm64_sonoma:  "5d1230237453a31206c26a56bac53823621842c717e40386b6d1859f5858dd63"
    sha256 cellar: :any, sonoma:        "2d9d4a0aa514c77d589296d38223e671892eb19107e9164067ce74084680fce5"
    sha256 cellar: :any, arm64_linux:   "32d0868ac51b5d77a8ffd3e2d21ced7c6b36ba56a3b933887e74939eb1633716"
    sha256 cellar: :any, x86_64_linux:  "5d91b7de5709841e829ee26d62e8ce81045173bbf4e0623be5a4cff0e0965489"
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
